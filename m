Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17579.18070.211297.508029@cargo.ozlabs.ibm.com>
Date: Wed, 5 Jul 2006 14:56:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 13/20] [powerpc,
	video & agp] Constify & voidify get_property()
In-Reply-To: <20060704190054.GA20952@redhat.com>
References: <20060704190054.GA20952@redhat.com>
Cc: linuxppc-dev@ozlabs.org, davej@codemonkey.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dave Jones writes:

> I assume this stuff is going in through the ppc tree?

Yes, I'll take care of it.  Once Linus releases -rc1 I'll start
pushing the for-2.6.19 patches (including these) to the master branch
of the powerpc.git tree.

Paul.
