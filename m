Message-ID: <40D70AE3.8070408@iti.fi>
Date: Mon, 21 Jun 2004 19:20:51 +0300
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Lite5200 PCI not working
References: <20040621151440.DEA80C13D3@atlas.denx.de>
In-Reply-To: <20040621151440.DEA80C13D3@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>Dear Kate,
>
>in message <40D6ECB0.6040301@iti.fi> you wrote:
>
>
>>Small notice about Coral-P card. Least one that i have needs separate -12V to connec to PCI
>>connector pins. There is no -12V supply on board. The Coral-P does itself  need
>>-12V but there is one analog mux in video output that needs -5V that is
>>generated from -12V.
>>
>>
>
>Are you really sure? Maybe it was just an issue of finding the  right
>jumper  settings (which is non-trivial). We tested both with Rev. 4.0
>and Rev. 5.0 cards, and didn't need -12V.
>
>
>
I am absolutelly sure. Ihe document mb86295eb01-schematics-190503.pdf in
page 8
has analog mux U25 EL4331C that takes to pin 13 -5V voltage that comes
from U251
79L05 regulator that generates it from -12V. Even there is bypass
jumpers JP 250-JP252
the EL4331C inputs still clamp video output levels. I really fighted
a long tive with debugging driver untill i found reason why there is no
video
signal.

My board is Rev 3.0 so, may be they have fixed it in 4.0 or 5.0 versions.



Kate


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
