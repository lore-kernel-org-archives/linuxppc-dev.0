Message-Id: <199901131359.WAA09324@smtp01.highway.ne.jp>
Date: Wed, 13 Jan 1999 22:57:41 +0900
To: "Ron Nelson" <rnelson@den.wantweb.net>,
        "David A. Gatwood" <marsmail@globegate.utm.edu>,
        Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org,
        Hubert Figuiere <Hubert.Figuiere@solsoft.fr>
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: Porting to NuBus PowerMacs
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> bh40@calva.net>
> Subject: Re: Porting to NuBus PowerMacs
> Date: Tue, 12 Jan 1999 22:40:11 -0700
> CC: linuxppc-dev@lists.linuxppc.org,Hubert Figuiere <Hubert.Figuiere@solsoft.fr

> >
> 
> 
> I know you guys are only in the early stages with this but I have a 6100 
> that I will run anything you come up with on.. I don't have mklinux on it
> right now but I could get that on it and be a guinea pig if you need one..
> 
> Ron Nelson
================================================================

       ---------------------------
         Rawhide world on MklinuxG06
        ---------------------------

 Let's go "Rawhide world" using the vmlinux+installer like DR3,
    together Nubus users too.

   This vmlinux+installer is useful linuxppc/R5 in linuxppc box,too.
    
   There is <ftp://ppc.linux/pub/users/fukui/Drugstore-in Rawhide
          /Installer-on-MkLinux-G06R5>. 

                                  Kaoru Fukui <fukui@ppc.linux.or.jp>
                                  Sun 10 Jan 1999

  ** How to install as MkLinux** 

 1. Download many RedHat/RPMS files from 
             ftp://ftp.linux.org/pub/linuxppc/linuxppc-pre-R5/RedHat/RPMS.
     Not use for linuxppc files.
     (kernel-pmac,kernel-prep,kernel-source,kernel-chrp,pmac-utils,linuxconf
)

     Put RPMS files on ext2.

     Remove filenames for linuxppc in comps,
      or use Installer-on-MkLinuxG06R5/RedHat/base/comps,it's alredy rewrite
.
    Download RedHat/base/hdlist and put it in RedHat/base. 

 2. Download these files from 
       ftp://ppc.linux.or.jp/pub/users/fukui/Drugstore-in-Rawhide/Installer-on-MkLinux-G06R5
/*.
     Add four files from Installer-on-MkLinux-G06R5/RedHat/RPMS/* 
     to Redhat/RPMS installed.
     (clock-mklinux,mklinux-release,mklinux_server,rc.loca-linuxppc)

     Add these filenames in comps,or use My comps.

 3. Uncompress Mac_Files.sit, put in MacOS.
 4. Put mach_servers in MacOs.
 5. Go restart Mac. 

 [note]
   I istalled R5 useing these files on PM6100.
   Then Select custom,Scsi driver is no,Disk Setup,use fdisk,
   Edit Partition is "/",
   Do link for startx function," cd /etc/X11,ln -sf /usr/X11R6/bin/Xpmac X"

 [Problem]
   The comps has many bugs.Take care.

   Xfree86-3.3.3-10d.ppc.rpm could not nomeal end.
   It,s works fine, but hitkey "ctrl D" to go freeze.
   I used to end "sync,reboot","sync,halt".

   More problem, it's not X_LOCAE, Xemacs doesnot work. 


 Mac_Files.sit have "Mach kernel" from globegate.utm.edu/MkLinux generic 06.
 The other fuiles are same.
 

>Installing the Mac OS-side files
>================================

>There are five files in the "Mac Files" folder.  Copy the two files "MkLinux

>Booter" and "Mach Kernel" to your Extensions folder.  Copy the control panel

>"MkLinux" to your Control Panels folder.  Copy the two files "lilo.conf" and

>"MkLinux.prefs" to your Preferences folder.

>The initial boot of MkLinux just runs the installer.  Currently, things are


 Vmlinux+installer was rebuilt using "Mklinux generic 06" and 
   "Linuxppc release 5's installer".

 I got ramdisk.image.gz-RH5-new from Martin's 
      <http://www.maths.univ-rennes1.fr/~costabel/linux/R5/>,
 it's have not /dev/* and not /mnt.
 Installer said "can not mount".
 I fixed that. Thanks Martin. 


Enjoy Rawhide on MklinuxG06!

Thanks
Kaoru Fukui <fukui@linux.ppc.or.jp>


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
