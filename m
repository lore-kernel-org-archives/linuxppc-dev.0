Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Time for cell code reshuffle?
Date: Wed, 26 Dec 2007 23:32:39 +0100
References: <20071226.204216.-1300525659.kouish@swc.toshiba.co.jp>
In-Reply-To: <20071226.204216.-1300525659.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712262332.40141.arnd@arndb.de>
Cc: jk@ozlabs.org, paulus@samba.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 26 December 2007, Ishizaki Kou wrote:
> Celleb-native needs own machine definition and setup code due to HW
> and FW deferences between CellBlade and Celleb. Of course, because
> Celleb-native and Celleb-Beat use some codes commonly, we need a place
> to put Celleb common codes.
> 
> But I don't know your idea is better or not.

The two more sensible options I can see are

* leave everything where it is, live with the problem that the
  separation between celleb-native, celleb-beat and ibm-native
  is unclear.
* put both celleb and the ibm blades into the cell subdirectory,
  now with three different machine descriptions in there and only
  make sure that platforms/cell doesn't share any code with ps3,
  which is more clearly separated already (once we move spufs out).

I'm fine either way, and will accept patches from Toshiba to merge
the two directories if you prefer that, but I won't do it myself.

	Arnd <><
