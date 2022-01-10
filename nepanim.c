#include "nepanim.h"


OBJ_ATTR obj_buffer[128];
OBJ_AFFINE* obj_aff_buffer = (OBJ_AFFINE*)obj_buffer;

int main()
{
    memcpy32(&tile_mem[4][0], sprites,  sprites_size);
    memcpy32(pal_obj_mem, sprPal, sprPal_size / 4);

    oam_init(obj_buffer, 128);
    REG_DISPCNT = DCNT_MODE0 | DCNT_OBJ | DCNT_OBJ_1D;

    int frame = 0;
    u32 tid = 0;
    OBJ_ATTR* anim = &obj_buffer[0];

    obj_set_attr(anim,
    ATTR0_SQUARE,
    ATTR1_SIZE_16,
    ATTR2_PALBANK(0) | tid);

    obj_set_pos(anim, 0x7F, 0x7F);

    while(true)
    {
        vid_vsync();
        if(frame%5==0)
        {
            tid+=4;
            if(tid>3*4)
                tid = 0;

            anim->attr2= ATTR2_BUILD(tid, 0, 0);

            oam_copy(oam_mem, obj_buffer, 1);
        }
        frame++;
    }
    return 0;
}