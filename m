Message-ID: <81A66F72DCACD511B0600002A551BFCB4E9D5C@kuumex05.barco.com>
From: "Callebaut, Benoit" <benoit.callebaut@barco.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Cc: "'emanuel stiebler'" <emu@ecubics.com>
Subject: RE: kernel boot on mpc8245, internal UART
Date: Thu, 6 Mar 2003 10:56:01 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


To know witch physical uart is mapped to which STTY, you must see in the
kernel the sanpoint_serial.h file in /arch/platform.
And to know whitch one is used by Linux at startup /etc/inittab.

-----Original Message-----
From: emanuel stiebler [mailto:emu@ecubics.com]
Sent: Wednesday, March 05, 2003 10:36 PM
To: linux-emb
Subject: Re: kernel boot on mpc8245, internal UART



> emanuel stiebler wrote:
>>I have a board which is close to Sandpoints mpc8245 cpu board.
>>(using internal DUARTs, EPIC_MODE_SERIAL)

Trying to figure out what is going wrong, I tried to locate the driver
for the internal DUART of the MPC8245 ...

So, probably a stupid question, but where is the link/information, or
where do I provide it, that the MPC8245 should use the internal UART as
a console on linux ?

Thanks a lot in advance, but I guess I got lost ...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
