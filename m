Date: 12 Aug 2002 14:24:14 -0000
Message-ID: <20020812142414.15872.qmail@webmail10.rediffmail.com>
MIME-Version: 1.0
From: "Narendra  " <narengh@rediffmail.com>
Reply-To: "Narendra  " <narengh@rediffmail.com>
To: "Michael Habermann" <MHabermann@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RequestIO : Resourse in Use
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Michael,

thanks for all your inputs.

I have made orinoco_cs.c driver recognise my card (D-link DWL50)
with ignore_cis_vcc = 1 option and card is successfully
configured.

But same thing if i try with my driver, i have failure returned at
card services (RequestIO) call. I don`t know why this is
happening?? and i have checked throughly my driver code..its seems
that no problem with the code(because my driver is working fine in
compaq Armada notebook).

now i am in deadlock situation, not able to proceed further..

Pls see the log below,
This is the output in /var/log/messages:
(some debug messages are added by me for testing)

Jan  1 00:01:47 10 kernel: unloading PCMCIA Card Services
Jan  1 00:01:48 10 kernel: Linux PCMCIA Card Services 3.2.0
Jan  1 00:01:48 10 kernel:   kernel build: 2.4.2_hhl20 #1 Fri
Aug
2 14:08:40 IST 2002
Jan  1 00:01:48 10 kernel:   options:  none
Jan  1 00:01:49 10 kernel: m8xx_pcmcia: Version 0.03,
14-Feb-2000,
Magnus Damm
Jan  1 00:01:49 10 kernel: m8xx_pcmcia: RPX CLASSIC or RPX LITE
using SLOT_B with IRQ 13.
Jan  1 00:02:07 10 kernel: WLAN: Card Service ReqSer 15 : Return
Value 0
Jan  1 00:02:08 10 kernel: WLAN: Card Service ReqSer 21 : Return
Value 0
Jan  1 00:02:08 10 kernel: WLAN: Card Service ReqSer 30 : Return
Value 0
Jan  1 00:02:08 10 kernel: Updating Base Address Success
Jan  1 00:02:08 10 kernel: WLAN: Card Service ReqSer 10 : Return
Value 0
Jan  1 00:02:08 10 kernel: Updating Vcc Success
Jan  1 00:02:08 10 kernel: WLAN: Card Service ReqSer 15 : Return
Value 0
Jan  1 00:02:08 10 kernel: Retriving Tuple from CF Table.
Jan  1 00:02:08 10 kernel: WLAN: Card Service ReqSer 21 : Return
Value 0
Jan  1 00:02:08 10 kernel: WLAN: Card Service ReqSer 30 : Return
Value 0
Jan  1 00:02:08 10 kernel: CF Table With Default Settings
Jan  1 00:02:08 10 kernel:  Configured Vcc = 50 and 33
Jan  1 00:02:08 10 kernel:  Vcc NOT equal
Jan  1 00:02:08 10 kernel: Enter IO window configuration
Jan  1 00:02:08 10 kernel: WLAN: Card Service ReqSer 45 : Return
Value 30
Jan  1 00:02:08 10 kernel: RequestIO: Resource in use (Why
RequestIO is failing?)
Jan  1 00:02:08 10 kernel: Configuration from CF Table FAILURE.

Thanks & Regards,
Naren



On Thu, 08 Aug 2002 Michael Habermann wrote :
>
>Narendra wrote:
>>I have one more problem,
>>Do i need to compile my kernel with Enabling PCMCIA support
>>and
>>then download to target? or Is it sufficient if all pcmcia
>>driver
>>modules are loaded to kernel??
>
>PCMCIA needs and should not be enabled in the kernel. The loading
>the
>modules is enough.
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
