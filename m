Date: Thu, 2 Sep 1999 18:39:06 -0700 (PDT)
From: Brad Midgley <brad@pht.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: new boot procedures (Re: LinuxPPC on CDROM as an emergency boot)
In-Reply-To: <19990902194938.025327@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.9909021440520.17575-100000@web1.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>some people have looked into making vmlinux new-OF-bootable but then it
>>must live on an hfs[+] partition and again we have no ramdisk capability.
> I'm interested in those fixes.

i've put some of the discussion on the subject and the relevant netbsd
sources online if you want to more easily browse them:
         http://web1.turbolinux.com/~brad/newboot/

the best plan of attack would be to first look at the kernel:

 - get vmlinux to boot from new OF directly
 - adapt kernel to allow for compiled-in ramdisk, as is done for prep

this allows for cdboot and a kind of hd boot, provided you have hfs[+];
then tackle quik:

 - get quik to work with new OF 
 - get quik to load ramdisks (this would be optional if we already have
   compiled-in-ramdisk support, even on older OF)

Brad
brad@pht.com | http://www.pht.com/~brad/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
