From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>,
	<yellowdog-devel@lists.terrasoftsolutions.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: funny kernel death with ksoftirqd_CPUX taking up almost 100% of
 cpu?
Date: Wed, 10 Jul 2002 18:24:03 +0200
Message-Id: <20020710162403.16035@192.168.4.1>
In-Reply-To: <200207101236.43005.kevin.hendricks@sympatico.ca>
References: <200207101236.43005.kevin.hendricks@sympatico.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I just experienced an alarming form of kernel death running a self compiled
>SMP kernel with HIGHMEM enabled on my dual G4 -1gig machine.
>
>The kernel tree used is Ben's 2.4.19-pre10 one rebuilt for SMP support, aec
>IDE driver and otherwise basically stock.
>
>I was debugging in gdb a large program and noticed typing got slower and
>slower.  I quick check of top showed that ksoftirqd_CPU was taking up
>almost 100% of the cpu.  I exited out of gdb and killed every process I
>could think of but the usage of that kernel demaon stayed at near 100%.

BTW. It would be interesting to know if you can ever reproduce it...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
