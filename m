From: "Kim, Kwansuk" <kskim@neowave.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: After add CONFIG_MODULES,it works noting?
Date: Tue, 8 May 2001 10:54:44 +0900
Message-ID: <OMENKEONFDLIGLHPFALBCEOHCCAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
In-Reply-To: <3AF74DF9.23628@bjapp4>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If you don't use driver as module, whenever you modify the driver you should compile the kernel.
(I think it's one of the reasons why module is used)

And if you want you the driver, I suggest using KGDB.
Using KGDB you can even debug dynamically linked modules by add-symbols command (maybe) during exploring (almost) all the kernel source.
There is the method in "Linux Device Drivers" (O'reilly) Chap. 4.

 ==============================================
  Kwansuk Kim
  Engineer, NeoWave Inc.
  Tel   +82-31-380-4927    Fax +82-31-380-4747
  E-mail: kskim@neowave.co.kr
==============================================

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org [mailto:owner-linuxppc-
embedded@lists.linuxppc.org]On Behalf Of zjuzhou@163.net
Sent: Tuesday, May 08, 2001 10:38 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: After add CONFIG_MODULES,it works noting?




hello,
        when i don't use CONFIG_MODULES in .config,HHL works well,but when i
add CONFIG_MODULES into kernel,i reboot my borad using new kernel,when it
uncompress kernel image,then do noting.Just like the question asked by somebody
before.
        By the way,i want to write driver,if don't use "ismod",how can i debug
my driver?i don't like compile kernel again and again.
        thanks.

Dross Chou


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
