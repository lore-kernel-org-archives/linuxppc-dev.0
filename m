From: supas100@astrophysik.uni-kiel.de (Derek Homeier)
Message-Id: <199901141731.SAA11562@juliet.astrophysik.uni-kiel.de>
Subject: Re: Apple's cdrom driver & non Apple CDROM drives
To: linuxppc-dev@lists.linuxppc.org
Date: Thu, 14 Jan 1999 18:31:04 +0100 (MET)
Cc: martins1@col.bsf.alcatel.fr
In-Reply-To: <199901140800.CAA24661@lists.linuxppc.org> from "owner-linuxppc-dev-digest@lists.linuxppc.org" at Jan 14, 99 02:00:02 am
Reply-to: Derek Homeier <homeier@astrophysik.uni-kiel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Jan 1999 16:00:22, Alexandre MARTINS MELO <martins1@col.bsf.alcatel.fr>
wrote:

> Hi,
>  
> does anybody know what CDROM drive models & constructors are supported
> by the apple cdrom driver ?
> I have a PM7200/75 and a Nec CDR222. Since I formatted my HD in HFS+, the
> cdrom driver seems to have problems with its cache file. It works, but
> very, very slowly.
>  
> With LinuxPPC, there's no problem, but I would like to play a bit with
> Lara Croft...
somewhat off topic, really, but look at the recent (or, meanwhile, perhaps 
'previous') news section at macintouch for two links describing a patch to 
the apple cdrom and dvd drivers to make them work with non-apple drives. 
One is at c't magazine:
	http://www.heise.de/ct/english/98/26/188/
the other one improves a bit on this in that it supports both apple and non-
apple drives with the same driver, but I don't have it at hand right now.

Hope this helps,
							Derek

-- 
Derek Homeier                                           Tel: +49-431-880-4103
Institut fuer Theoretische Physik und Astrophysik       Fax: +49-431-880-4100
der Christian-Albrechts-Universitaet                    Feet:        Room 142
D-24098 Kiel, Germany		      email:  homeier@astrophysik.uni-kiel.de


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
