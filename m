Mime-Version: 1.0
Message-Id: <p04320418b5b9f21900aa@[192.168.1.1]>
In-Reply-To: <200008110500.AAA07294@lists.linuxppc.org>
References: <200008110500.AAA07294@lists.linuxppc.org>
Date: Fri, 11 Aug 2000 12:12:15 -0600
To: linuxppc-dev@lists.linuxppc.org
From: "David L. Thompson" <dthompsn@cs.umt.edu>
Subject: char is not signed char
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anybody else noticed that char is not signed char but unsigend
char? If I write the following:

#include <stdio.h>

int main() {

	char a = -3;
	if(a > 0)
		printf("Ooops!\n");
	return 0;
}

and run it, I get Oooops!

Currently I have installed fsirl's 2.95.3 version of gcc.


Thanks,
David
--
.............................................................................
David L. Thompson                          The University of Montana
mailto:dthompsn@cs.umt.edu                 Computer Science Department
http://www.cs.umt.edu/u/dthompsn           Missoula, MT  59812
                                            Work Phone : (406)257-8530

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
