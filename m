Message-ID: <366E598E.CCF78F93@zg.tel.hr>
Date: Wed, 09 Dec 1998 12:05:53 +0100
From: Stanko Juzbasic <stanko.juzbasic@zg.tel.hr>
Reply-To: stanko.juzbasic@zg.tel.hr
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-user@lists.linuxppc.org
Subject: AUDIO ON LINUX_PPC
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is there anybody who encounterde the following problem?
I'm  constantly running into something that seems like a problem with
sound:
1. SOX plays .wav, .au .snd & .aiff files with gaps, whoch looks to me
 like a disagreement on timing issues between the kernel buffer
 &application buffer. (I've recompiled the kernel a few times).

2. CDs from the internal scd drive play flawlessly.

3. Other utilities (such as Wavplay, rawplay) either don't execute, or
don't
 compile, or don't install or refuse to run without Motif (lesstif)
shared
 libraries such as libXm.so.1 etc, which in turn configure but don't
make,
 and give thousands of warnings, hanging in infinite loops...

My platform:  PCI-PowerMac 7200, PowerPC 601 processor.
System:   LINUX_PPC R4, kernel 2.1.24 (configured as standalone
   workstation)
All drives: SCSI

I'd like to know if this is a known problem and if so, is there any hope

this would be resolved for the next release. I'm not concernerd with
8 kHz - 8 bit - 150:1 compressed system beeps. All I care for is playing

plain 16 bit integer linear format files.




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
