From: Anton Blanchard <anton@linuxcare.com.au>
Date: Sat, 17 Feb 2001 23:18:18 +1100
To: Tony Mantler <nicoya@apia.dhs.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ltrace for ppc
Message-ID: <20010217231818.G3000@linuxcare.com>
References: <20010216210927.A9F26DBA2E@atlas.valhalla.net> <v04003a02b6b35c7a4a82@[24.70.162.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <v04003a02b6b35c7a4a82@[24.70.162.12]>; from nicoya@apia.dhs.org on Fri, Feb 16, 2001 at 04:47:18PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> What about SGI's Kernprof stuff? <http://oss.sgi.com/projects/kernprof/>.

It should be easy to port this and SGI's lockmeter (spinlock metering)
to PPC if they haven't already been. I ported them to sparc64 a while ago
and they have been quite useful.

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
