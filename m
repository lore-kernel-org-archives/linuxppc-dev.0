Message-ID: <40921B50.2000106@euronet.nl>
Date: Fri, 30 Apr 2004 11:24:32 +0200
From: Jos Beck <jos_beck@euronet.nl>
MIME-Version: 1.0
To: Stan Partridge <SPartridge@CTDI.COM>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Unable to get SCC 4 working as a console port on a 8260ADS
References: <A0CF3E6CD78CD411B369009027B0FCFE04313412@MIMIR>
In-Reply-To: <A0CF3E6CD78CD411B369009027B0FCFE04313412@MIMIR>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stan Partridge wrote:

> A few seconds later the console terminal spews pages and pages of the
> following junk:
>
> ∫0@ê¿!∫ê@

> ¿!p ¿!p @¿¿!pP¿!pP@¿!p

This looks like your port is set to another (probably much lower) baud
rate. Try to set your terminal to other baudrates and see what happens.
Then check the settings of baudrate generators and prescaler.

Good luck

Jos


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
