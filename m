Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18039.31768.282185.497245@cargo.ozlabs.ibm.com>
Date: Tue, 19 Jun 2007 16:47:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 18/33] PS3: Frame buffer system-bus rework
In-Reply-To: <46730D32.8060803@am.sony.com>
References: <20070615204749.629571012@am.sony.com>
	<46730D32.8060803@am.sony.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand writes:

> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> 
> Convert the ps3fb device from a platform device to a PS3 system bus device.
> Fix the remove and shutdown methods to support kexec and to make ps3fb a
> loadable module.

Are you going to submit this to the fb maintainer (Antonio Daplas?) or
do you want me to take it because of dependencies on other patches in
your series?

Paul.
