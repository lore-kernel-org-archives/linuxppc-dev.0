Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <d90126080903182237i6057e9afi9051723685bcb2d2@mail.gmail.com>
References: <d90126080903182237i6057e9afi9051723685bcb2d2@mail.gmail.com>
Date: Thu, 19 Mar 2009 00:01:02 -0600
Message-ID: <fa686aa40903182301l63d9319r40a9e8e20f89af5a@mail.gmail.com>
Subject: Re: [PATCH 1/9] of: add of_parse_phandle() helper for parsing
From: Grant Likely <grant.likely@secretlab.ca>
To: sunder ramani <sunder.svit@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>,
	afleming@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 18, 2009 at 11:37 PM, sunder ramani <sunder.svit@gmail.com> wrote:
> To Summarize, should not we have a phy_type flag in the OF tree which
> will let the PHY layer do the various PHY tasks based on if it is a
> copper/fiber interface. I really dont like my fix in my kernel and am
> new to open source. Do you think it is a valid argument? If it so, I
> would like to plan to introduce those changes and post to the
> community.

Yes, we probably do need some form of flag here for describing the PHY
interface.  Feel free to post a suggested binding for this.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
