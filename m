Mime-Version: 1.0
Message-Id: <p05111b02b9422ba7534a@[10.8.16.89]>
Date: Fri, 28 Jun 2002 10:10:44 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Greg Allen <gallen@arlut.utexas.edu>
Subject: CONFIG_BLOCK_DEV_RAM in linuxppc_2_4_devel
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just did a bk pull on my modified linuxppc_2_4_devel tree, and it
no longer compiles.

snippit from init/do_mounts.c, line 381

    #if defined(CONFIG_BLOCK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
    static void __init change_floppy(char *fmt, ...)
    {


The linker complains that this function should be present.

I have CONFIG_BLK_DEV_RAM turned on, and no floppy. I can't find any
other reference to CONFIG_BLOCK_DEV_RAM.

Is this simply a typo that never got tested without CONFIG_BLK_DEV_FD
turned off?

Could one of the maintainers fix this little problem?

Thanks,
-Greg
--
  Gregory E. Allen, MSEE Engineering Scientist
  Applied Research Laboratories: The University of Texas at Austin
  Please help find my missing daughter: http://FindSabrina.org/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
