To: Amit.Lubovsky@infineon.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: u-boot mbx860 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 30 Sep 2003 18:36:17 +0200."
             <AD2F581BD7340A4C908AF1AFB066EA3B0E4839@ntah901e.savan.com>
Date: Tue, 30 Sep 2003 23:50:33 +0200
Message-Id: <20030930215038.C3CB2C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Amit,

in message <AD2F581BD7340A4C908AF1AFB066EA3B0E4839@ntah901e.savan.com> you wrote:
>
> Data Size:    1333838 Bytes = 1302.58 kB = 1.27 MB
----------------^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> => tftp 20000 ppc.img

0x20000 = 128 kB. There is not enough room to copy 1.27 MB.

Try:

	=> tftp 200000 ppc.img


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Beware of programmers carrying screwdrivers."      - Chip Salzenberg

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
