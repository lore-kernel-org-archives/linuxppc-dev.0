Message-ID: <008901be73b2$0f1bb6c0$499672cf@sunshinecomputing.com>
From: "Brian Macy" <bmacy@sunshinecomputing.com>
To: <linuxppc-dev@lists.linuxppc.org>, <linuxppc-user@lists.linuxppc.org>
Subject: Fw: Linux 2.2.3ac4
Date: Sun, 21 Mar 1999 07:46:59 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I didn't see this on the list already... figured you guys might like the
fact that Alan expects this one to compile out of the box.

Brian Macy

----- Original Message -----
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: <linux-kernel@vger.rutgers.edu>
Sent: Saturday, March 20, 1999 7:20 PM
Subject: Linux 2.2.3ac4


>
> Ok I've put up a 2.2.3ac4. The distribution site has changed. Its now
> on ftp.*.kernel.org thanks to HPA and the guys at Transmeta.
>
> ftp.*.kernel.org:/pub/linux/kernel/alan/2.2
>
> ac4 is a big diff, but most of it shared with the Linus pre4, so the
> actual scale of difference isnt as dramatic as it looks - its mostly the
> long awaited Linus/DaveM/etc merge of sparc/sparc64/ppc
>
> Differences between 2.2.3ac3 and 2.2.3ac4
>
> o msr definition cleaned up (Philipp Rumpf)
> o Merged with Linus current pre4
> | This should mean sparc and ppc work out of the box
> o Another IP DoS fix (John McDonald)
> | Hopefully with this an ANK's routing fixes 2.2.3ac* contains
> | all the fixes to the DoS problems in 2.2.x (x<=3)
> o NFSD flushes cached handles (G. Allen Morris III)
> o NTFS fixes (Al Viro)
> o Make "nolock" mean "lock on client only"(Matthew Grant)
> | We now match 2.0 behaviour
> o Merged the remaining NFS error changes
> from 2.2.3
>
>
> Differences between 2.2.3ac2 and 2.2.3ac3
>
> o 3c527 packet sending fix (me)
> o I2O controllers flush cache on reboot (me)
> o Waveartist driver might work on x86 now (me)
> o Put ppc header additions in the right
> place (duh)
> o Misc doc fixes (various)
> o Fix the flock crash (Adrian Sun)
> o First set of IP routing fixes (Alexey Kuznetsov)
> | People seeing the ENOBUFS problem can you
> | see if this fixes it
> o IDE update for flash removables (Mark Lord)
> o Changes updates (Chris Ricker)
> o ICMP masquerading (Keith Owens)
> | This should fix the masquerade/hanging with low MTU
> | problems for the cases where its not the remote site buggy
>
>
> Differences between 2.2.3ac1 and 2.2.3ac2
>
> o FIOASYNC corrected (Godmar Back)
> o Cleaner lp fix (Tim Waugh)
> o MSR defintion in one place (Philipp Rumpf)
> o NBD thinko fix (Andries Brouwer)
> o Don't need to use ls in Makefile (Zygo Blaxell)
> o Ultrasparc typo fix (Dave Jones)
> o Creat doesnt need to grab kernel lock (Tigran A. Aivazian)
> o Amiga partition update (Hans-Joachim Widmaier)
> | Handles disks that have been attacked by Windows 95
> | Handles media with large block sizes
> o First phase of Sangoma merge (Sangoma)
> | This is partial - need to sort a couple of items
> | with Sangoma for this.
> o Fixed the signal bug I let in (me)
> o 3Com 3c527/IBM HPerf Lan Adapter driver (me)
> o Experimental I2O layer (me)
> | Block & SCSI OSM's only. Tested on the Symbios 40920 only
> o AF_UNIX fixes (Andrea)
> o Vfork inherited wrong stats (Andreas Schwab)
> o SMP safe ibmtr driver (Tim Hockin)
> o Digi EPCA driver update (Digi)
> o PPC semaphore stuff (Paul Mackerras)
> o Quota fixes with NFS etc (Andrea)
> o CDROM Update (Jens Axboe)
> o 2Gig RAM support for Alpha (Richard Henderson et al)
> o Qlogic FC updates (Chris Loveland)
> o Roadrunner HIPPI update (Jes Sorenson)
> o Scsi generic updates (Douglas Gilbert)
> o SPX module bug fix (Andrzej M. Krzysztofowicz)
> o bw-qcam allow port specification (Billy Donahue)
> o Midi synth typo fix (Joseph H. Buehler)
> o Source route & Syn cookie fix (Andi Kleen)
>
> Linux 2.2.3ac1 contains
>
> o ARM updates - working to merge ARM with my tree then eventually I
> hope with Linus - tho that may be a 2.3 job
>
> o V7 file system tweaks to sys5 1K
>
> o Improved SCSI generic (still the mark 1 edition) - Douglas
> has some improvements in the pipeline before it goes to Linus
>
> o The Large file array patch. I still hope to feed this to Linus at
> some point
>
> o i386 security hole fix for ptrace. Its in the other architectures
> too. It only bites if you use capabilities. The bigger hole in
> /proc is fixed in 2.2.3
>
> o AMD K6 MSR/MTRR setup. The MSR is ready to go to Linus now, and
> will do so, the MTRR stuff I hope will get merged with Richard
> Gooch stuff once its untangled from devfs
>
> o ADFS update. Strictly for Acorn fans
>
> o CDROM updates. Heading Linuswards soon
>
> o Better bw-qcam driver.
>
> o Printing fixes. I assume Tim will send these to Linus himself when
> he's finally happy
>
> o 3c509 update - for EISA etc - queued for Linus
>
> o Wavelan update - queued for Linus
>
> o cs89x0 module parameters - queued for Linus
>
> o Sealevel sync driver. Awaiting confirmation it works on the real
> board as well as my test rig
>
> o SCSI blacklist and AIC7xxx updates
>
> o Prototype ESS PCI and Yamaha PCI legacy mode drivers. Gus SMP fix
>
> o NTFS doesnt crash when you run out of memory
>
> o /proc/mem crash fixes for threaded abuse programs
>
> o NFS: Im still merging together Linus & Trond's code. Once Trond
> has all the nice stuff finally tuned up with Linus this will all
> become main tree stuff. Im just making sure it gets tested 8)
>
> o NFSroot argument bug
>
> o Misc include/time wrap bug fixes
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/
>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
