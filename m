Message-ID: <40EC682F.5090004@bluewin.ch>
Date: Wed, 07 Jul 2004 23:16:31 +0200
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Stephen Williams <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: rpm for embedded system
References: <21704-45627@sneakemail.com> <40EC4D3E.5090405@bluewin.ch> <1138-00007@sneakemail.com>
In-Reply-To: <1138-00007@sneakemail.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 07/07/2004 09:30 PM Stephen Williams wrote:
> Wolfgang Grandegger wolfgang.grandegger-at-bluewin.ch |PPC Linux
> Embedded| wrote:
>> On 07/07/2004 09:11 PM Stephen Williams wrote:
>>
>>>I'm using ELDK-3 from Denx for my ppc based board, which has
>>>disk space (in the form of a compact flash) that I want to
>>>manage using rpm. (I'd like to rpm install the eldk packages
>>>that I want on my target.)
>>>
>>>So I'm looking for a cross-rpm howto. Seems like the ppc_4xx-rpm
>>>that comes with the ELDK gets me half way there.
>>
>>
>>
>> Check http://www.denx.de/twiki/bin/view/DULG/ELDKRebuildingComponents
>
> Almost. That is instructions for remaking the ELDK packages
> from the src.rpms. But I want to take the existing binary
> rpms and install them on my owh root. This does *not* work:
>
>    ppc_4xx-rpm --root=/mnt/flash foo.ppc.rpm
>
> I want to do something like that with the packages, so that
> I can install individual existing ppc.rpm packages from the
> ELDK disk onyl by flash card.

Hm, have a look to the ELDK CDROM, especially check the ".list" files in
/mnt/cdrom/etc. They actually define the packages to be installed. You
might copy parts of the tree to disk and tailor the list files according
to your needs. Then you should be able to install the RPM packages with
the "install" utility as usual. Nevertheless, a root file system built
this way is very large, too large for most embedded systems.

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
