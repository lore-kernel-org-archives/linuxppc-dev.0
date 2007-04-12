Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070412200431.GA9067@lixom.net>
References: <20070410111508.GA2969@localhost.localdomain>
	<200704121501.34311.arnd@arndb.de>
	<981B07C8-D35B-4581-8FC7-DCA58430A081@kernel.crashing.org>
	<200704121926.03723.arnd@arndb.de>
	<04335E0C-3963-4849-BEC7-DC9DF3E3280F@kernel.crashing.org>
	<20070412200431.GA9067@lixom.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b57c243b6ec8978136c7d29233d0994b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [RFC, PATCH] selection of CPU optimization
Date: Thu, 12 Apr 2007 22:01:11 +0200
To: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Olof should know what pa6t needs or what makes sense for it.
>
> Thanks for the heads up, I didn't notice the email go by on the list.
>
> -m{cpu,tune}=pa6t should do it.

Except that's not in any public GCC version yet.  Well,
two weeks ago it wasn't...

Note that specifying an unknown -mcpu/tune= is an error,
not a warning or totally ignored.


Segher
