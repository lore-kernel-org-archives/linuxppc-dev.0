Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 22 Dec 2009 11:58:41 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Joel Schopp <jschopp@austin.ibm.com>
Subject: Re: [PATCH] powerpc: update ibm,client-architecture
Message-ID: <20091222005841.GM30375@ozlabs.org>
References: <1261170452.8134.13.camel@jschopp-laptop>
	<29526.1261353566@neuling.org> <4B2FBB3F.8030703@austin.ibm.com>
	<7024.1261429935@neuling.org> <4B2FF35E.9020101@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4B2FF35E.9020101@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 21, 2009 at 04:14:54PM -0600, Joel Schopp wrote:

> It's a bad interface.  No matter what you choose there will be a
> downside.  1) If you choose NR_CPUS, the best case of how many you
> could boot without SMT, then when you boot with SMT2 or SMT4 you can
> get assigned more cpus than you can boot.  2) If you choose
> NR_CPUS/4, the worst case of how many you could boot, and you get a
> large machine with SMT2 or SMT1 you might have said you support less
> cpus than you actually do and thus not boot all the cpus.  So no
> matter what you choose you could be not booting cpus in some
> theoretical scenario.

We're far enough through boot to determine the threading model, so you /could/
work out what SMT we're in and divide NR_CPUS by that and give that to firmware.

Yours Tony
