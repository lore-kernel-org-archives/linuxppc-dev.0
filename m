Message-ID: <1138-00007@sneakemail.com>
Date: Wed, 07 Jul 2004 12:30:19 -0700
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: rpm for embedded system
References: <21704-45627@sneakemail.com> <40EC4D3E.5090405@bluewin.ch>
In-Reply-To: <40EC4D3E.5090405@bluewin.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Grandegger wolfgang.grandegger-at-bluewin.ch |PPC Linux
Embedded| wrote:
> On 07/07/2004 09:11 PM Stephen Williams wrote:
>
>>I'm using ELDK-3 from Denx for my ppc based board, which has
>>disk space (in the form of a compact flash) that I want to
>>manage using rpm. (I'd like to rpm install the eldk packages
>>that I want on my target.)
>>
>>So I'm looking for a cross-rpm howto. Seems like the ppc_4xx-rpm
>>that comes with the ELDK gets me half way there.
>
>
>
> Check http://www.denx.de/twiki/bin/view/DULG/ELDKRebuildingComponents

Almost. That is instructions for remaking the ELDK packages
from the src.rpms. But I want to take the existing binary
rpms and install them on my owh root. This does *not* work:

   ppc_4xx-rpm --root=/mnt/flash foo.ppc.rpm

I want to do something like that with the packages, so that
I can install individual existing ppc.rpm packages from the
ELDK disk onyl by flash card.
--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
