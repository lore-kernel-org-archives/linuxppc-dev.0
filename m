Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id F2E9568378
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Sep 2005 03:16:03 +1000 (EST)
Date: Mon, 26 Sep 2005 10:15:11 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: smiling_23 <smiling_23@nerdshack.com>
Message-ID: <20050926171511.GB13009@mag.az.mvista.com>
References: <432FFE87.6020100@nerdshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <432FFE87.6020100@nerdshack.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: porting Linux on ppc7a
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 20, 2005 at 05:50:23PM +0530, smiling_23 wrote:
> Hi all,
>           I am tryin to port Linux on ppc7a radstone board. I have seen 
> two threads on porting linux on ppc7a, There
> he mentioned ppc7a board is similar to EV64260  board. I tried to get 
> the data sheets of EV64620, i failed to found this
> board data sheets. If any one has this board data sheets , web link or 
> any information please send the information to me.
> Thanks and regards,
> Venkata jagadish.p.

Before you go too far, did you look to see what already in the community
source?  There is a port to the radstone ppc7d.  I don't know but I
wouldn't be surprised if its pretty close to your ppc7a.

If you want docs on Marvell products like the ev64260, you need to sign an NDA
(last time I checked).

Mark
