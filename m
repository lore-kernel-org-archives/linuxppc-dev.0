Return-Path: <iwankoenig@yahoo.de>
Message-ID: <20060926064451.71706.qmail@web26012.mail.ukl.yahoo.com>
Date: Tue, 26 Sep 2006 08:44:51 +0200 (CEST)
From: Iwan Koenig <iwankoenig@yahoo.de>
Subject: Asterisk on Embedded Linux
To: Linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Does anyone known how to compile Asterisk for a
powerpc-processor?
I have tryed:
./configure --target=powerpc-linux
--host=powerpc-604-linux-gnu --prefix=/opt/packages
And it gives following error:
 /root/pwlib/include/ptlib.h... configure: error:
cannot check for file existence when cross compiling

Ok! I see that it is trying to find the PWLIB-Library.
Also, i have tryed to compile the pwlib.
But it didn't work :(. For PWLIB i need the OpenLDAP,
and when i have compiled the OpenLDAP, than needs
PWLIB other packages.......
Also, have anyone ideas, how to compile Asterisk für a
powerpc-processor with another way?

Thanks!!!!


	

	
		
___________________________________________________________ 
Der frühe Vogel fängt den Wurm. Hier gelangen Sie zum neuen Yahoo! Mail: http://mail.yahoo.de
