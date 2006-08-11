Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 8B34067BB5
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 06:28:13 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 0/4]:  powerpc/cell spidernet ethernet driver fixes
Date: Fri, 11 Aug 2006 22:27:22 +0200
References: <20060811170337.GH10638@austin.ibm.com>
	<20060811174439.GA30191@mars.ravnborg.org>
	<20060811193102.GN10638@austin.ibm.com>
In-Reply-To: <20060811193102.GN10638@austin.ibm.com>
MIME-Version: 1.0
Message-Id: <200608112227.24140.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Sam Ravnborg <sam@ravnborg.org>, Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 11 August 2006 21:31, Linas Vepstas wrote:
> I put my name at the top when I was the primary author. 
> I put Jim's name at the top when he was the primary author. 
> 
> Both names are there because I sat in Jim's office and used
> his keyboard. I got him to compile and run the tests on
> his hardware, and we'd then debate the results.

When the patch gets added to a git repository, they end up
having your name on it, because the author is determined
from the person who sent the patch.

For the patches where Jim is the main author, you should put a 

From: James K Lewis <jklewis@us.ibm.com>

into the first line of the email body. That will make the
scripts do the right thing. The order of the Signed-off-by:
lines is used is independant from authorship and should
list the name of the submitter last.

	Arnd <><
