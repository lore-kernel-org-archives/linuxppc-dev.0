Message-ID: <38597379.21E4FB7E@ctam.com.au>
Date: Fri, 17 Dec 1999 10:19:22 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: linuxppc-embedded: nfsroot is WORKING !!!
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



I finally got nfsroot to work.  I changed
    #define NFS_DEF_FILE_IO_BUFFER_SIZE 4096
to
    #define NFS_DEF_FILE_IO_BUFFER_SIZE 1024
in include/linux/nfs_fs.h.


All programs will now run from an nfs server.  Yippee :)

Now, is it just an incompatiblility with old nfs servers on 2.0.x
kernels ?
I would assume that it SHOULD be backward compatible.

I guess I should upgrade my Intel boxes to a distribution that uses
2.2.x kernels (though that should not be necessary) and change the
default buffer size back to 4096.

Has anyone else seen a similar problem connecting to nfs servers running
on older kernels ?

Thanks for everyones help,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
