Return-Path: <aiyuanwang@yahoo.com>
Received: from web52904.mail.re2.yahoo.com (web52904.mail.re2.yahoo.com
	[206.190.49.14]) by ozlabs.org (Postfix) with SMTP id 3F2B5B6EF6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Dec 2009 18:18:14 +1100 (EST)
Message-ID: <304699.14564.qm@web52904.mail.re2.yahoo.com>
References: <401793.31718.qm@web52903.mail.re2.yahoo.com>
	<20091201231022.AB72CE6D391@gemini.denx.de>
	<880531.39933.qm@web52905.mail.re2.yahoo.com>
	<20091202200942.506BF4C025@gemini.denx.de>
Date: Sat, 12 Dec 2009 23:18:11 -0800 (PST)
From: Allan Wang <aiyuanwang@yahoo.com>
Subject: Re: EP440XS board boot problem(Note:similart to Sequoia)
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20091202200942.506BF4C025@gemini.denx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-63006677-1260688691=:14564"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0-63006677-1260688691=:14564
Content-Type: text/plain; charset=us-ascii

Hello, Mr. Denk,

I forgot to give you the uboot printenv output.
=> printenv
bootcmd=run flash_self
bootdelay=5
baudrate=115200
loads_echo=1
preboot=run setup_phys;echo;echo Type "run flash_nfs" to mount root filesystem over NFS;echo
netdev=eth0
hostname=ep440xs
nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=$(serverip):$(rootpath)
ramargs=setenv bootargs ramdisk=65536 root=/dev/ram rw
addip=setenv bootargs $(bootargs) ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):off panic=1
addtty=setenv bootargs $(bootargs) console=ttyS0,$(baudrate)
flash_nfs=run nfsargs addip addtty;bootm $(kernel_addr)
flash_self=run ramargs addip addtty;bootm $(kernel_addr) $(ramdisk_addr)
net_nfs=tftp 200000 $(bootfile);run nfsargs addip addtty;bootm
kernel_addr=fe000000
ramdisk_addr=fe180000
load=tftp 0x200000 u-boot.bin
update=protect off 0xfff60000 0xffffffff;era 0xfffa0000 0xffffffff;cp.b 0x200000 fffa0000 60000
upd=run load;run update
usbact=hostdev
fixedip=setenv bootargs $(bootargs) ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):off panic=1
dhcp=setenv bootargs $(bootargs) ip=dhcp
initphy=mii w ${phy} 14 e3;mii w ${phy} 18 4101;mii w ${phy} 9 e00;mii w ${phy} 4 1e1;mii w ${phy} 0 9140;mii w ${phy} 0 1140
setup_phys=setenv phy 0;run initphy;setenv phy 1;run initphy;setenv phy
progee=mw 0x100000 0x87788252;mw 0x100004 0x0957a030;mw 0x100008 0x40082350;mw 0x10000c 0x0d050000;eeprom write 0x54 0x100000 0x0 0x10
diags=cp.b 0xFFF40000 0x40000 0x20000;go 0x40004
dhcp_user-class-id=u-boot_test
rootpath=/opt/ppc/ppc_4xx
bootfile=cuImage.ep440xs
ipaddr=192.168.0.201
netmask=255.255.255.0
ethaddr=00:01:ec:01:12:83
eth1addr=00:01:ec:81:12:83
ethact=ppc_4xx_eth0
gateway=192.168.0.1
bootargs=$(bootargs) console=ttyS0,$(baudrate)
serverip=192.168.0.196
gatewayip=192.168.0.1
stdin=serial
stdout=serial
stderr=serial
ver=U-Boot 1.1.6 (Oct 25 2009 - 13:26:41)

Thanks,

Allan


      
--0-63006677-1260688691=:14564
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:arial,helvetica,sans-serif;font-size:12pt">Hello, Mr. Denk,<br><br>I forgot to give you the uboot printenv output.<br>=&gt; printenv<br>bootcmd=run flash_self<br>bootdelay=5<br>baudrate=115200<br>loads_echo=1<br>preboot=run setup_phys;echo;echo Type "run flash_nfs" to mount root filesystem over NFS;echo<br>netdev=eth0<br>hostname=ep440xs<br>nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=$(serverip):$(rootpath)<br>ramargs=setenv bootargs ramdisk=65536 root=/dev/ram rw<br>addip=setenv bootargs $(bootargs) ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):off panic=1<br>addtty=setenv bootargs $(bootargs) console=ttyS0,$(baudrate)<br>flash_nfs=run nfsargs addip addtty;bootm $(kernel_addr)<br>flash_self=run ramargs addip addtty;bootm $(kernel_addr) $(ramdisk_addr)<br>net_nfs=tftp 200000 $(bootfile);run nfsargs addip
 addtty;bootm<br>kernel_addr=fe000000<br>ramdisk_addr=fe180000<br>load=tftp 0x200000 u-boot.bin<br>update=protect off 0xfff60000 0xffffffff;era 0xfffa0000 0xffffffff;cp.b 0x200000 fffa0000 60000<br>upd=run load;run update<br>usbact=hostdev<br>fixedip=setenv bootargs $(bootargs) ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):$(netdev):off panic=1<br>dhcp=setenv bootargs $(bootargs) ip=dhcp<br>initphy=mii w ${phy} 14 e3;mii w ${phy} 18 4101;mii w ${phy} 9 e00;mii w ${phy} 4 1e1;mii w ${phy} 0 9140;mii w ${phy} 0 1140<br>setup_phys=setenv phy 0;run initphy;setenv phy 1;run initphy;setenv phy<br>progee=mw 0x100000 0x87788252;mw 0x100004 0x0957a030;mw 0x100008 0x40082350;mw 0x10000c 0x0d050000;eeprom write 0x54 0x100000 0x0 0x10<br>diags=cp.b 0xFFF40000 0x40000 0x20000;go
 0x40004<br>dhcp_user-class-id=u-boot_test<br>rootpath=/opt/ppc/ppc_4xx<br>bootfile=cuImage.ep440xs<br>ipaddr=192.168.0.201<br>netmask=255.255.255.0<br>ethaddr=00:01:ec:01:12:83<br>eth1addr=00:01:ec:81:12:83<br>ethact=ppc_4xx_eth0<br>gateway=192.168.0.1<br>bootargs=$(bootargs) console=ttyS0,$(baudrate)<br>serverip=192.168.0.196<br>gatewayip=192.168.0.1<br>stdin=serial<br>stdout=serial<br>stderr=serial<br>ver=U-Boot 1.1.6 (Oct 25 2009 - 13:26:41)<br><br>Thanks,<br><br>Allan<br><br><!-- cg20.c2.mail.re1.yahoo.com compressed/chunked Thu Dec 10 19:48:41 PST 2009 -->
</div><br>



      </body></html>
--0-63006677-1260688691=:14564--
