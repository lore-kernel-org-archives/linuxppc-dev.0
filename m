Return-Path: <tmarri@apm.com>
Received: from exprod5og113.obsmtp.com (exprod5og113.obsmtp.com [64.18.0.26])
	by ozlabs.org (Postfix) with SMTP id C74D9B713B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 08:17:14 +1000 (EST)
Received: by qwj9 with SMTP id 9so961475qwj.24
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 09 Sep 2010 15:17:11 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <a3a9eb5a2e770f931950ad13c01960da@mail.gmail.com>
	<20100909004853.GA11808@zod.rchland.ibm.com>	<49073d172310031addb3aa7d08a60c99@mail.gmail.com>
	<20100909063601.03CCE1506AA@gemini.denx.de>	<56886bb653a2198b7a5bdcf5f38d4a98@mail.gmail.com>
	<20100909130954.265adb37@lappy.seanm.ca>
In-Reply-To: <20100909130954.265adb37@lappy.seanm.ca>
MIME-Version: 1.0
Date: Thu, 9 Sep 2010 15:17:10 -0700
Message-ID: <69da3260c595cc3870a9ff1eee9a7898@mail.gmail.com>
Subject: RE: Combining defconfigs for 44x based boards
To: Sean MacLennan <smaclennan@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Thu, 9 Sep 2010 09:49:14 -0700
> Tirumala Marri <tmarri@apm.com> wrote:
>
> > [Marri] Great we already have it. We should remove the defconfigs
> > under 44x then ?
>
> I'd rather we didn't. I thought Linus' beef was over the churn in the
> defconfigs, not the fact that they exist. The 44x defconfigs change
> very rarely.
[Marri]That is kind of true. Can we create new defconfigs then ?
I am trying to check-in new defconfig.
