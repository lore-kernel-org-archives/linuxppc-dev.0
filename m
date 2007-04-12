Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070412042337.GA21832@aepfle.de>
References: <20070410111508.GA2969@localhost.localdomain>
	<1176240168.8061.51.camel@localhost.localdomain>
	<20070411025605.GB2197@localhost.localdomain>
	<1176262253.8061.60.camel@localhost.localdomain>
	<ffb78cbadfea8d104c8e5d495e9651ca@kernel.crashing.org>
	<20070412042337.GA21832@aepfle.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6ffa9deb122ae953e58a88103fcfc8b9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 3/3] cell: prevent alignment interrupt on local store
Date: Thu, 12 Apr 2007 08:50:27 +0200
To: Olaf Hering <olaf@aepfle.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Akinobu Mita <mita@fixstars.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> This isn't just a kernel issue either; the same holds
>> for all of userspace.  It seems to me the only way to
>> get good performance on both Cell and all other platforms
>> is to have a separate binary distribution for Cell.
>
> How much will this impact performance on a 970, 74xx or POWER6 if
> everything gets compiled with '--mcpu=$cell', compared to what is used
> today? One gets at least altivec that way.

Can't comment on POWER6; but on 74xx or 970 it will
hurt.  A lot.  Say 20-%30% or so?  [Yes I have no
benchmark data to back this up].


Segher
