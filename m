Reply-To: <zjhzou@newrocktech.com>
From: "ZhongJun Zhou" <zjhzou@newrocktech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: kernel memory mapping problem
Date: Thu, 7 Feb 2002 11:21:13 +0800
Message-ID: <OOEJKGLHOBHLNAIEBLEFAEMFKJAA.zjhzou@newrocktech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3F31161C.6000901@dgt-lab.com.pl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

I have a problem that :

the function is :

int func()
{
	unsigned char tmp[10];
	unsigned char * p;

	p = __pa(tmp);
	...
	pI2cRxBD -> bd_addr = p;
	...
	...
}
when run this module( lsmod mymodule.o ), kernel is always dead. Are there any errors of this function ?

Any help is appreciated!

John Zhou

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
