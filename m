MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Xilinx ML300 u-boot question
Date: Tue, 13 Apr 2004 10:04:13 -0600
Message-ID: <8039970AF146314597457D3B51A68B388F377F@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You can build custom kernels with built-in values instead of using the boot line to set the values.  That would be simpler than chaining u-boot because u-boot expects a bare machine on start up.  To chain u-boot, you basically would have to make a "run from RAM" u-boot -- while not impossible, it takes time and effort and isn't a supported configuration (i.e. Wolfgang won't answer your questions in his usual thorough manner ;-).

You should be able to use the command language built into u-boot to select linux bootline parameters.  You must be able to detect differences in the target systems in order to load a custom u-boot or linux -- why not use that with the u-boot conditional commands to select or build up the proper linux bootline?

gvb


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Mike
> Wellington
> Sent: Tuesday, April 13, 2004 11:29 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Xilinx ML300 u-boot question
>
>
>
> Does anybody know what parameters I should use to
> load u-boot, using u-boot.    That's right, I want to
> build a generic u-boot that goes on the Microdrive of
> a Xilinx ML300 development board.  I have several of them
> to manage.  I want the generic u-boot to go and download
> a machine-specific u-boot that I can change on my workstation
> without having to write it to the microdrive.
>
> Or can I just have u-boot start the kernel with no parameters
> and have all the initial args for the kernel built into the
> kernel?
>
> -mike wellington
>   wellington@lucent.com
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
