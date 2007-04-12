Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [RFC, PATCH] selection of CPU optimization
Date: Thu, 12 Apr 2007 21:25:57 +0200
References: <20070410111508.GA2969@localhost.localdomain>
	<200704121926.03723.arnd@arndb.de>
	<04335E0C-3963-4849-BEC7-DC9DF3E3280F@kernel.crashing.org>
In-Reply-To: <04335E0C-3963-4849-BEC7-DC9DF3E3280F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704122125.57484.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 12 April 2007, Kumar Gala wrote:
> > What would be the right options to pass on e200 and on
> > pa6t?
> 
> I think leaving it blank is the right thing for e200.

Leaving it blank means it will use the compiler's default
target, which can be anything. My guess is that '-mcpu=powerpc'
would be right, i.e. no 64 bit, no POWER, but most PowerPC
instructions are allowed.

	Arnd <><
