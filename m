Message-ID: <3D7739F8.8030106@lvl7.com>
Date: Thu, 05 Sep 2002 07:03:20 -0400
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: Tom Stefanski <tom.stefanski@seranoa.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can't disassemble my device driver
References: <3D76870E.5244CED5@seranoa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Stefanski wrote:

> I have a adatron bdi 2000 connected to my target board and have
> successfully load the linux kernel and set breakpoint in schedule
> However when I load my device driver, it's text section is a 0xD11D6060
> and the kernel is a 0xC00xxxxx. When is disassemble any routine in my
> driver, I get all zeros.
>
>  I have MMU xlate set in the config file and I program the mmu correctly
> since I can break a schedule. Any help would be apprecciated
>
>
>  Tom
>
>
>

Did you remember to specify the text address when you added the symbol file in
gdb?  If you didn't type 'help add-symbol-file' in gdb and it will explain where
you can specify the starting text address of your device driver module.
Neil
--
/******************************************************************
*Neil Horman
*Software Engineer
*LVL7 Systems
*13000 Weston Pkwy.
*Cary, NC 27513
*(919)-865-2915
*nhorman@lvl7.com
*PGP keyID 0xB5E1020A
*http://www.keyserver.net/en
*******************************************************************/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
