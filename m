Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910802091838x3e596debj113089faef08c1c8@mail.gmail.com>
Date: Sat, 9 Feb 2008 21:38:53 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Linux/PPC Development" <Linuxppc-dev@ozlabs.org>
Subject: of_iomap and request_mem_region
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

of_iomap doesn't implicitly do a request_mem_region().  How should
request_mem_region() be handled? When using of_iomap you don't get the
length of the region back so it isn't easy to call request_mem_region.

What about adding a third param to of_iomap for the driver name? If it
is non-null also do the request region. If it is null check to make
sure the region has already be requested.

-- 
Jon Smirl
jonsmirl@gmail.com
