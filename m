To: linuxppc-embedded@lists.linuxppc.org
From: =?ISO-8859-1?Q?Stefan_St=FCrke?= <sst@pandatel.com>
Subject: Re: m8xx hang in reboot
Date: Thu, 26 Aug 2004 08:40:57 +0200
Message-ID: <cgk0lp$5dk$1@sea.gmane.org>
References: <Pine.LNX.4.61.0408251615540.9890@chef.linux-wlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <Pine.LNX.4.61.0408251615540.9890@chef.linux-wlan.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark S. Mathews wrote:
>
> Hey Folks,
>
> I've got an mpc850 based setup running 2.4.27 that, under certain
> circumstances, hangs in the the m8xx_restart() function (instead of
> rebooting) when I issue the usermode reboot cmd.
>
> I've traced all through the path and confirmed that yes, it is hanging in
> this function.  ;-)

Maybe you can have a look at your boot flash when you enter the
m8xx_restart() function. I had a similar problem and found that
my boot flash was in read status state in that moment, so it was
impossible to fetch the correct programm code after reset.

HTH,
Stefan

--
PANDATEL AG
Bayernstrasse 33
30855 Langenhagen
Germany

Tel.: +49 (0)511 978199-15
Fax.: +49 (0)511 978199-77
mailto:sst-news2003@pandatel.com
www.pandatel.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
