Return-Path: <markn@au1.ibm.com>
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC 0/3] powerpc: memory copy routines tweaked for Cell
Date: Fri, 20 Jun 2008 10:04:02 +1000
References: <200806191753.51495.markn@au1.ibm.com>
	<200806191559.04852.arnd@arndb.de>
	<F5386B83-6DD2-4503-9ADD-C0CDE21101ED@lixom.net>
In-Reply-To: <F5386B83-6DD2-4503-9ADD-C0CDE21101ED@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806201004.02749.markn@au1.ibm.com>
Cc: Gunnar von Boehn <VONBOEHN@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
	Michael Ellerman <ellerman@au1.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Jun 2008 12:53:49 am Olof Johansson wrote:
> 
> On Jun 19, 2008, at 8:59 AM, Arnd Bergmann wrote:
> 
> > I assume it has suffered from bitrot and nobody tried to do better
> > since the Power3 days. AFAICT, it hasn't seen any update since your
> > original Power4 version from 2002.
> 
> I've got an out-of-tree optimized version for pa6t as well that I  
> haven't bothered posting yet.
> 
> The real pain with the usercopy code is all the exception cases. If  
> anyone has made a test harness to make sure they're all right, please  
> do post it for others to use as well...

I second that request - I verified (to the best that I could) with
pen and paper that the exception handling on this new version
is correct but it would be great to have a better way to test it.

Mark
