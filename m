Message-Id: <4.3.2.20010321074303.00be5a70@falcon.si.com>
Date: Wed, 21 Mar 2001 07:48:57 -0500
To: "shalini  jain" <shalijain@rediffmail.com>,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: What do you all say of the file size ???
In-Reply-To: <20010321024258.19911.qmail@mailweb30.rediffmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


man fstat

               struct stat
               {
                   dev_t         st_dev;      /* device */
                   ino_t         st_ino;      /* inode */
                   mode_t        st_mode;     /* protection */
                   nlink_t       st_nlink;    /* number of hard links */
                   uid_t         st_uid;      /* user ID of owner */
                   gid_t         st_gid;      /* group ID of owner */
                   dev_t         st_rdev;     /* device type (if inode
device) */
                   off_t         st_size;     /* total size, in bytes */
                   unsigned long st_blksize;  /* blocksize for
filesystem I/O */
                   unsigned long st_blocks;   /* number of blocks
allocated */
                   time_t        st_atime;    /* time of last access */
                   time_t        st_mtime;    /* time of last
modification */
                   time_t        st_ctime;    /* time of last change */
               };

In particular, element st_size.

There is no EOF character stored in the file, that went out of style
with CP/M.  Although DOS/WinXX still support EOF characters, that
doesn't change the validity of my assertion.

If you are trying to find the file size of a raw disk partition that
has been formatted ext2 without using the linux file system resources
(i.e. fstat()), that is a pretty significant undertaking and you will
just have read and understand the ext2 sources.  You are not likely to
get much help or sympathy from this list.

gvb


At 02:42 AM 3/21/01 +0000, shalini  jain wrote:

>hello list,
>
>can someone suggest the way to find the file size in ext2fs ?(provided
>the no. of blocks are known)
>
>is there any EOF char in ext2fs files ? if yes. what is it ? is there
>any other way of knowing the file size than to count up to EOF ???
>
>
>if possible, please reply in a bit detail.
>thanx,
>Shalini
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
