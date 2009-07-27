Return-Path: <wilbur512@gmail.com>
MIME-Version: 1.0
Date: Tue, 28 Jul 2009 00:39:48 +0800
Message-ID: <e997b7420907270939x432d96bja704eaaea96788a@mail.gmail.com>
Subject: Is it a BUG of kexec in E500?
From: "wilbur.chan" <wilbur512@gmail.com>
To: Linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I found a patch for kexec on Booke  in the archives:

http://lists.ozlabs.org/pipermail/linuxppc-dev/2008-November/064798.html

In this pacth , we use an entry to  setup a 1:1 mapping , whose size
is 1GB. However, in e500, the max mapping size for

a single entry is 256M. So I have to setup 4 entries to map 1G kernel
space in my mpc8541.

Is  it a bug here ?  I'm not quite sure.




regards,
