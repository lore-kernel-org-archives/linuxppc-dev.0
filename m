Message-ID: <407C2524.2070807@lucent.com>
Date: Tue, 13 Apr 2004 11:36:36 -0600
From: Mike Wellington <wellington@lucent.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Xilinx ML300 u-boot question
References: <8039970AF146314597457D3B51A68B388F377F@cossmgmbx02.email.corp.tld>
In-Reply-To: <8039970AF146314597457D3B51A68B388F377F@cossmgmbx02.email.corp.tld>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gerald (et al) -

1)  kernel configuration  - tried changing the default
kernel command line, but that didn't work.  The kernel
started up, but did not set its "ip=" parameters as I
specified.  This method would work fine, but I'd prefer
to not have to keep a separate kernel around for each
machine.

2) conditional execution commands from u-boot - this sounds
like a good option, I don't know anything about these commands.
I guess I can distiguish one from another via the IP address.
I'll persue this.  And thanks for saving me from wasting my
time trying to make a RAM only u-boot.

-mike wellington
  wellington@lucent.com
  platforms@bithead.com


VanBaren, Gerald (AGRE) wrote:
> You can build custom kernels with built-in values instead of using the boot line to set the values.  That would be simpler than chaining u-boot because u-boot expects a bare machine on start up.  To chain u-boot, you basically would have to make a "run from RAM" u-boot -- while not impossible, it takes time and effort and isn't a supported configuration (i.e. Wolfgang won't answer your questions in his usual thorough manner ;-).
>
> You should be able to use the command language built into u-boot to select linux bootline parameters.  You must be able to detect differences in the target systems in order to load a custom u-boot or linux -- why not use that with the u-boot conditional commands to select or build up the proper linux bootline?
>
> gvb
>
>
>
>>-----Original Message-----
>>From: owner-linuxppc-embedded@lists.linuxppc.org
>>[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Mike
>>Wellington
>>Sent: Tuesday, April 13, 2004 11:29 AM
>>To: linuxppc-embedded@lists.linuxppc.org
>>Subject: Xilinx ML300 u-boot question
>>
>>
>>
>>Does anybody know what parameters I should use to
>>load u-boot, using u-boot.    That's right, I want to
>>build a generic u-boot that goes on the Microdrive of
>>a Xilinx ML300 development board.  I have several of them
>>to manage.  I want the generic u-boot to go and download
>>a machine-specific u-boot that I can change on my workstation
>>without having to write it to the microdrive.
>>
>>Or can I just have u-boot start the kernel with no parameters
>>and have all the initial args for the kernel built into the
>>kernel?
>>
>>-mike wellington
>>  wellington@lucent.com
>>
>>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
