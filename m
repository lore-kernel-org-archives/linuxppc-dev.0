Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17978.45028.471162.619967@cargo.ozlabs.ibm.com>
Date: Fri, 4 May 2007 14:00:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: olof@lixom.net (Olof Johansson)
Subject: Re: [PATCH v3] powerpc: Show current speed in /proc/cpuinfo
In-Reply-To: <20070504031611.GB5567@lixom.net>
References: <20070427084118.GA8842@lixom.net>
	<20070430035339.GA15771@lixom.net>
	<20070504031611.GB5567@lixom.net>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> On other architectures, the frequency in /proc/cpuinfo moves with cpufreq
> changes. It makes sense to do the same on powerpc to keep users from
> getting confused.

Well, it does on powermac already, because ppc_proc_freq gets
adjusted...  So at the very least, your patch description needs to be
changed.

Do you have a situation where the CPUs in a system can have different
clock frequencies?  If not, why not just set ppc_proc_freq when the
frequency changes?

Paul.
