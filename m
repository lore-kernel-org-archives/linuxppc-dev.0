Date: Sat, 21 Apr 2001 11:38:33 +0800
From: byf <byfmail@yeah.net>
To: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Cc: embeded powerpc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re:  Can I use RiscWatch to load ppcboot?
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Message-Id: <20010421033908.F402B1C766C79@smtp2.yeah.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have can load ppcboot to ram and run it.
How can I boot from sram when reset?

Thank you!


ÔÚ 2001-04-20 12:18:00 ÄúÐ´µÀ£º
>byf wrote:
>
>> Hello,
>>
>> I am working for walnut 405GP, it has a ROM Monitor and RiscWatch.
>> now I want to use PPCBoot to overwrite ROM Monitor,
>> Can I use RiscWatch to load PPCBoot to flash or to ram and run it?
>>
>
>yes. I use the onboard SRAM walnut has a switch that exchange the flash and
>sram address. So once you load it you can actually reset the machine and it
>will boot just like you had programmed a real flash just don't tun the power
>off :)
>
>--
>Kenneth Johansson
>Ericsson Business Innovation AB   Tel: +46 8 404 71 83
>Viderögatan 3                     Fax: +46 8 404 72 72
>164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

                    ÖÂ
Àñ£¡

            byf
            byfmail@yeah.net


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
