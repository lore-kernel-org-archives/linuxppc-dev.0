Date: Wed, 22 Jan 2003 22:33:25 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: wrong definition in cpm_8260.h?
In-reply-to: <3E2EDD3E.1000502@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>
Cc: Shen Rong <rshen@udtech.com.cn>,
	linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLGEIOFJAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=Windows-1252
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > The same error is in commproc.h for 8xx as well.
>
> It's not an error in either driver since first/last will always be
> set in every buffer.  There isn't any reason for the driver to test
> or take any action based upon these indicators.

Yes, the CPM will set these flags, but will it also clear them if the
buffer is not first/last in a frame? I think not.

I know that the driver is designed to always set them so in practise it
won't be problem. However this could change some day.

Also, is it not time to remove the code contained in #ifndef final_version macros?

>
> These are not data transfer error or status indicators in the sense
> they indicate some condition on the network itself.  These are buffer
> management indicators that should be managed as such if they are used.

yes I know, but I still think those flags should be included in the RX_STATS macro.


    Jocke
>
> Thanks.
>
>
> 	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
