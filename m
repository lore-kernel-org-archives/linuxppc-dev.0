Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17634.64640.709200.871907@cargo.ozlabs.ibm.com>
Date: Wed, 16 Aug 2006 21:07:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: PowerPC paxtest results w/ gcc-4.1
In-Reply-To: <20060816105925.GB21865@iram.es>
References: <17630.27174.711916.643790@cargo.ozlabs.ibm.com>
	<000301c6bf97$e9151e00$99dfdfdf@bakuhatsu.net>
	<17633.18057.778991.483461@cargo.ozlabs.ibm.com>
	<20060816105925.GB21865@iram.es>
Cc: 'Albert Cahalan' <acahalan@gmail.com>, debian-powerpc@lists.debian.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gabriel Paubert writes:

> I agree, but I don't know why you believe it would cause 
> a machine check (0x200): from my docs, it is an ISI (0x400). 

I don't believe it would cause a machine check either, but that is
what Matt Sealey was saying.  I don't know where he got that idea.

> BTW, there is one way to make pages non executable: mark
> them as guarded, but it will have a significant cost in
> terms of performance. 

Indeed.  I guess we could do that as a config option for machines that
really want maximum security at the expense of performance, but I
don't think all users would want that.

Paul.
