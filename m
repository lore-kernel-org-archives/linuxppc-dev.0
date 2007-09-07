Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch v2] Cell: Wrap master run control bit
Date: Sat, 8 Sep 2007 00:46:42 +0200
References: <46DD4783.9040103@am.sony.com> <200709050042.13926.arnd@arndb.de>
	<46E0A8C8.9030505@am.sony.com>
In-Reply-To: <46E0A8C8.9030505@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200709080046.43882.arnd@arndb.de>
Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 07 September 2007, Geoff Levand wrote:

> v2:
>  o Added comments about unmapping PS pages when disabled.

What about my comment about making the new functions return void?

	Arnd <><
