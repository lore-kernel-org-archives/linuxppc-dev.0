Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040209134447.7F1E2C108D@atlas.denx.de>
References: <20040209134447.7F1E2C108D@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <93314AB1-5B9D-11D8-B8DD-000A95B15278@aimsys.nl>
Cc: linuxppc-embedded@lists.linuxppc.org,
	JACK HWAN <jhfami@yahoo.co.kr>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Subject: Re: Booting time 
Date: Tue, 10 Feb 2004 08:48:54 +0100
To: Wolfgang Denk <wd@denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Feb 9, 2004, at 2:44 PM, Wolfgang Denk wrote:
>
> For a "standard" system with 50 MHz CPU and 50 MHz bus  clock  I  can
> demonstrate  that  it takes not more than 3...4 seconds from power on
> until the first application process is running.

Wolfgang,

What kind of setup is that? A very small ramdisk or flash disk?
Does the (u-) boot loader do extensive ram tests?

thanks,

Jaap-Jan

>
> Best regards,
>
> Wolfgang Denk
>
> --
> See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> It is dangerous to be right on a subject  on  which  the  established
> authorities are wrong.                                    -- Voltaire
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
