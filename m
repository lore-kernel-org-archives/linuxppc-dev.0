Message-Id: <se2ed94f.020@mail.kieback-peter.de>
Date: Wed, 22 Jan 2003 17:47:57 +0100
From: "Klaus Heydeck" <Heydeck@kieback-peter.de>
To: "<" <linuxppc-embedded@lists.linuxppc.org>
Subject: Antw: Re: Lauterbach ICD In-Circuit Debugger
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>
>> A lot of people suggest to use the Abatron BDI2000 as debug system. I used
>> the Lauterbach TRACE32-ICD system with ARM processors without MMU (no
>> Linux) and it works extremely well.
>> The manufacturer claims it fully supports both the MMU and the Linux kernel
>> (see here for more details
>> http://www.lauterbach.com/cgi-bin/docloc.pl?file=rtoslinux.pdf). Can
>> anybody who used it confirm this point?
>
>I can. You can debug the kernel and e.g. interrupts using virtual
>addresses very well, you just have to specify the mapping
>(e.g. for ppc map phys 0x00000000 to 0xc0000000)
>
>I've not looked in detail yet to debug user processes.
>
We are using the TRACE32-ICD (MPC8xx) with U-Boot and Kernel 2.4.4.
Kernel debugging works without any problems. User space debugging is also
fine - but only if you don't have to debug shared libraries :-(
I think the T32 is a very good choice for kernel debugging, especially if you
have experience with the GUI and don t need the documentation or online help ;-)
If the problems with the shared libs are solved you have _one_ debugger for
kernel and applications.

Best regards,
Klaus Heydeck

--
Klaus Heydeck
Kieback & Peter GmbH & Co KG
Abt. Softwareentwicklung
Tempelhofer Weg 50
12347 Berlin / Germany
Tel. +49 30 60095 522
Fax. +49 30 60095 540


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
