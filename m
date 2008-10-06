Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id 6341DDE0EA
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 04:32:02 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2726767rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 06 Oct 2008 10:32:00 -0700 (PDT)
Date: Mon, 6 Oct 2008 11:31:58 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/2] OF: add fsl,mcu-mpc8349emitx to the exception list
Message-ID: <20081006173158.GA11208@secretlab.ca>
References: <20080923141219.GA31262@oksana.dev.rtsoft.ru>
	<20080930124424.GA6878@oksana.dev.rtsoft.ru>
	<20081001132248.191e92b3@hyperion.delvare>
	<20081001113948.GA20115@oksana.dev.rtsoft.ru>
	<20081006172831.GA27233@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081006172831.GA27233@oksana.dev.rtsoft.ru>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	Ben Dooks <ben-linux@fluff.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 06, 2008 at 09:28:31PM +0400, Anton Vorontsov wrote:
> On Wed, Oct 01, 2008 at 03:39:48PM +0400, Anton Vorontsov wrote:
> [...]
> > > > Any issues with this or the second patch? Can we merge them?
> > > 
> > > I do not have the time to review these patches (and, honestly, have no
> > > interest in them.) So I will not merge them but I have no objection to
> > > them being merged by somebody else.
> > 
> > Ok, thanks for the sincerity.. ;-)
> > 
> > Kumar, could you pick up the two patches via the patchworks?
> > 
> > [1/2] OF: add fsl,mcu-mpc8349emitx to the exception list
> > http://patchwork.ozlabs.org/patch/1105/
> > 

Since I've been involved with the i2c of bindings, I can pick this one up.

> > [2/2] i2c: MPC8349E-mITX Power Management and GPIO expander driver
> > http://patchwork.ozlabs.org/patch/1106/

But I'm not involved enough with this one, so it should go through
kumar.

g.
