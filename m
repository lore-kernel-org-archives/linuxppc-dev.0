Return-Path: <michael@ellerman.id.au>
Message-ID: <1339633701.30154.2.camel@concordia>
Subject: Re: Replacement to of_register_platform_driver ?
From: Michael Ellerman <michael@ellerman.id.au>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Date: Thu, 14 Jun 2012 10:28:21 +1000
In-Reply-To: <4FD8AFF2.6000702@lpsc.in2p3.fr>
References: <4FD8AFF2.6000702@lpsc.in2p3.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-06-13 at 17:21 +0200, Guillaume Dargaud wrote:
> Hello all,
> I just updated to the most recent kernel and a driver I wrote last year 
> won't compile:
> xad.c:534:2: error: implicit declaration of function 
> 'of_register_platform_driver'
> 
> I see references to this function as 'obsolete' but could not find 
> what's the new recommended way to do things.

The "of" bits were merged with the regular platform driver. So you
should use a platform_driver, which basically means remove "of_"
everywhere.

cheers
