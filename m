Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <002901c2061c$1d564840$7301a8c0@zhongqx>
From: "zhongqx" <zhongqx@guoguang.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: linux booting 
Date: Tue, 28 May 2002 15:48:51 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

   I use ppcboot to booting linux ,but linux cann't go on when malloc some memory.My board is FADS860T,
it has 4M DRAM(in physical 0---3fffff) and 4M SDRAM(in physical address is 03000000-033fffff),when ppcboot
run up,i use bdi command find it tell me total memory is 8M which is from 0 to 7fffff.i think ppcboot maped
two memory block into one continuous memory block(are i right?).when ppcboot boot linux it pass bdi to linux,
so i don't know whether linux kernel  understand the memory 0---7fffff is actualy  two memory block which
is 0----3fffff and 03000000 -033fffff.who can tell me how to understand this.sorry for my bad english.thank
you!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
