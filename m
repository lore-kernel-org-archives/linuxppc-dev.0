Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40707091003n45870ccdn8c9a3629cf19cf77@mail.gmail.com>
Date: Mon, 9 Jul 2007 11:03:29 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jcrigby@gmail.com>
Subject: Re: [PATCH] Add USB support to mpc8349-mitx board port
In-Reply-To: <4b73d43f0707082055y2b96fa53td55d6b381b6fb0ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070706222909.19943.39455.stgit@trillian.secretlab.ca>
	<200707070148.20526.arnd@arndb.de>
	<fa686aa40707062246j71a347acje8559b7b6be9d38b@mail.gmail.com>
	<4b73d43f0707071734yeedd7e6g53101d45fbec899e@mail.gmail.com>
	<fa686aa40707071748g7f00f4c7jb761cceb7d72456d@mail.gmail.com>
	<4b73d43f0707082055y2b96fa53td55d6b381b6fb0ef@mail.gmail.com>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/8/07, John Rigby <jcrigby@gmail.com> wrote:
> I see your point, I agree the two layers of glue is bad.  But this means
> the double code is spread across many drivers instead of being in one
> place (fsl_soc.c).

???  I don't understand what you mean.  Are you saying that it's
better to have all the OF bindings in one place (fsl_soc.c) instead of
with each individual driver?

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
