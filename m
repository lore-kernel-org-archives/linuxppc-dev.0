Return-Path: <Hiroshi_DOYU@montavista.co.jp>
Received: from yuubin.montavista.co.jp (sonicwall.montavista.co.jp
	[202.232.97.131])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D66EB2BF06
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Oct 2004 10:19:05 +1000 (EST)
Received: from oreo.montavista.co.jp (oreo.jp.mvista.com [10.200.16.31])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with ESMTP id i9LNvXXR004853
	for <linuxppc-embedded@ozlabs.org>; Fri, 22 Oct 2004 08:57:33 +0900
Date: Fri, 22 Oct 2004 08:57:33 +0900
From: Hiroshi DOYU <Hiroshi_DOYU@montavista.co.jp>
To: linuxppc-embedded@ozlabs.org
Message-Id: <20041022085733.0c5289c8.Hiroshi_DOYU@montavista.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [BUG] IBM440GX works too slow under nfsroot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

Now I am strugging with booting vanilla(2.4.2x) on ibm440gx and
I could succeed to boot it but, after nfs mounted, it's behavior 
seems too slow. I guess, it looks like the system is running 
half duplex. I have attached  the boot message below.

If anyone knows some information about such issue, please let me know.

Thanks,
-doyu

----------------
.....
Generic RTC Driver v1.07                                                                               
emac: IBM OCP EMAC Ethernet driver, version 2.0                                                        
Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>                                        
mal0: Initialized, 4 tx channels, 2 rx channels                                                        
zmii0: bridge in SMII mode                                                                             
eth0: IBM emac, MAC 00:04:ac:e3:2a:f5                                                                  
eth0: Found Generic MII PHY (0x01)                                                                     
eth1: IBM emac, MAC 00:04:ac:e3:2a:f7                                                                  
eth1: Found Generic MII PHY (0x02)                                                                     
NET4: Linux TCP/IP 1.0 for NET4.0                                                                      
IP Protocols: ICMP, UDP, TCP, IGMP                                                                     
IP: routing cache hash table of 2048 buckets, 16Kbytes                                                 
TCP: Hash tables configured (established 16384 bind 32768)                                             
Sending BOOTP requests .<6>eth0: Link is Up                                                            
eth0: Speed: 10, Half duplex.                                                                          
. OK                                                                                                   
IP-Config: Got BOOTP answer from 192.168.1.10, my address is 192.168.1.2                               
IP-Config: Complete:                                                                                   
      device=eth0, addr=192.168.1.2, mask=255.255.255.0, gw=192.168.1.10,                              
     host=ibm440gx, domain=, nis-domain=(none),                                                        
     bootserver=192.168.1.10, rootserver=192.168.1.10, rootpath=/opt/montavista/pro/devkit/ppc/440/tart
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.                                                    
Looking up port of RPC 100003/2 on 192.168.1.10                                                        
Looking up port of RPC 100005/1 on 192.168.1.10                                                        
VFS: Mounted root (nfs filesystem).                                                                    
Mounted devfs on /dev                                                                                  
Freeing unused kernel memory: 76k init                                                                 
nfs: server 192.168.1.10 not responding, still trying                                                  
nfs: server 192.168.1.10 not responding, still trying                                                  
nfs: server 192.168.1.10 OK                                                                            
nfs: server 192.168.1.10 OK                                                                            
nfs: server 192.168.1.10 not responding, still trying
nfs: server 192.168.1.10 OK                                         
.....
----------------
