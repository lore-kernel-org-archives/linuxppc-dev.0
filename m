From: "puppet" <puppetlee@hanmail.net>
Reply-To: "puppet" <puppetlee@hanmail.net>
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: unresovled symbol atomic_...
Date: Thu, 05 Apr 2001 15:22:50 KST
Message-Id: <20010405152250.HM.E0000000001QtCy@www15.hanmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


when I inserted module, following errors ocurred.

unresloved symbol atomic_dec
unresloved symbol atomic_inc

atomic_dec and atomic_inc are declared as inline function in "asm/atomic.h". As far as I know, inline function can be used in module without a problem like unresloved symbol.

Anybody help me to resolve this ?


==================================================
우리 인터넷, Daum
평생 쓰는 무료 E-mail 주소 한메일넷
지구촌 한글 검색서비스 Daum FIREBALL
http://www.daum.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
