From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Jeglinski <jeglin@4pi.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: old-world boot freeze; 2.4.19-rc2
Date: Sat, 20 Jul 2002 20:05:34 +0200
Message-Id: <20020720180534.29622@192.168.4.1>
In-Reply-To: <p05100300b95ea06f444c@[192.168.0.22]>
References: <p05100300b95ea06f444c@[192.168.0.22]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Just rsynced 2.4.19-rc2 from source.mvista.org (although official
>kernel is at rc3?). Built fine, but when I try to boot it on a 9500
>with a Powerlogix G3 upgrade, the last two things I see (early in the
>boot) are:
>
>setup_arch: enter
>setup_arch: bootmem
>
>And then it just locks up.
>
>Any ideas? Last kernel I've been running on this is 2.4.18, with no problems.

I works fine on a 8500 SMP here (with no G3 upgrade though). Can you
try routing printk to the btext engine ?
(use my tree and add printkbext to the command line)
Tell me what are the last messages.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
