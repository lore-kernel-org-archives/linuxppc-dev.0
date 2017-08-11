Return-Path: <ldoktor@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTK9362VYzDr2k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 19:15:19 +1000 (AEST)
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
To: ldoktor@redhat.com, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com, john.stultz@linaro.org,
 tglx@linutronix.de, sboyd@codeaurora.org, shuah@kernel.org,
 linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/1] rtc: rtctest: Support opal-rtc and rtc-generic
Date: Fri, 11 Aug 2017 11:14:54 +0200
Message-Id: <20170811091455.11041-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On ppc64le machines the opal-rtc, resp rtc-generic in guest is used. They only
support minimal set of functionality and fail this test in not-yet treated
way. This extends the checks and skips to the next test when feature is not
supported.

Lukáš Doktor (1):
  rtc: rtctest: Improve support detection

 tools/testing/selftests/timers/rtctest.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.9.4
