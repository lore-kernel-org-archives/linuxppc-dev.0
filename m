Message-ID: <81A66F72DCACD511B0600002A551BFCB4E9D35@kuumex05.barco.com>
From: =?iso-8859-1?Q?=22Callebaut=2C_Beno=EEt=22?= <benoit.callebaut@barco.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: FW: [U-Boot-Users] Accessing environment from linux? 
Date: Fri, 14 Feb 2003 11:40:54 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I looked a bit in the /tools/env directory and the code seems pretty good (I
haven't test it yet).
My question is maybe a little off topic here but anyway.
In the standard char driver for MTD devices, I see nowhere a piece of code
doing flash identification, or even calling low level read/write functions
for the flash (eg cfi commands).
How is this done ? I don't really understand when the mtd_table is filled in
using add_mtd_device.
This function is only used in mtdpart and in the device-mapping drivers.
But I don't want to use partition and if it possible, I don't want to make a
mapping driver.

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Friday, February 14, 2003 11:22 AM
To: Goddeeris Frederic
Cc: U-Boot-Users@Sourceforge. Net (E-mail); "Callebaut, Benoit";
'rod_boyce@stratexnet.com'
Subject: Re: [U-Boot-Users] Accessing environment from linux?


In message <6B546A602AD2D211BFF00008C7A4288905844178@hrtades2.atea.be> you
wrote:
>
> Some time ago (a year?) I downloaded SELF and found some busybox
> applets for
> manipulating the environment variables. Recently I have been looking to
> find
> perhaps a more recent version, but I had the impression it was no
> longer
> included. Why, I thought it is a clean solution?

Did you bother to check the recent discussion on tyhis list? All this
has been discussed just a couple of days before.

> I am using the "redundant environment variables" feature and adapted
> the
> busybox applets I found before. It works fine but there was no real
> clean
> way to introduce the feature in the existing code and it should be
> reworked.
> Anybody interested?

Is there anything  wrong  with  the  existing  and  working  code  in
tools/env ?


Why did you reinvent the wheel?


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
See us @ Embedded World, Nuremberg, Feb 18-20, Hall 12.0 Booth 12-442

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
