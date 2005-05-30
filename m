Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 30 May 2005 15:07:00 +1000
Message-Id: <1117429620.5228.38.camel@gaston>
Mime-Version: 1.0
Subject: symlinks in /proc/device-tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

Is anybody actually using one of these things in /proc/device-tree ?

 - for a node name@address, symlinks from name->node and @address->node
 - the fact that we remove the @address part if address is 0

I'm considering killing both of these things for 2.6.13. That will
reduce the memory footprint of the device-tree significantly (bloat in
inode cache) and it will be a more exact representation of the actual
tree. Besides, the symlinks are not really useful in practice.

Ben.
  
