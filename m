Message-ID: <377B315B.BBC64BA6@mpifr-bonn.mpg.de>
Date: Thu, 01 Jul 1999 11:14:03 +0200
From: Albrecht =?iso-8859-1?Q?Dre=DF?= <ad@MPIfR-Bonn.MPG.de>
MIME-Version: 1.0
To: LinuxPPC Users <linuxppc-user@lists.linuxppc.org>
CC: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: LinuxPPC & gcc optimizer flags
Content-Type: multipart/mixed;
 boundary="------------9DC1AE5D05AFD88BD7A6B247"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------9DC1AE5D05AFD88BD7A6B247
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi all,

	there was recently some discussion about the usage of different gcc optimizer
flags with LinuxPPC.  I ran the HINT benchmark on may PowerBook G3/300, 192 MB
Ram, LinuxPPC Release 5 with all combinations of the -O[0123] and
-mcpu={|603|604|750} flags.  Plots of the results are attached as ps files.
Interestingly, the best results are achieved with "-O2 -mcpu=603" or "-O3
-mcpu=603" and NOT with -mcpu=750....

BTW, the HINT homepage is http://www.scl.ameslab.gov/HINT/

Albrecht.

-- 
+-----------------------------------------------------------------------------+
| Dr.-Ing. Albrecht Dre\ss                                     ----           |
| Max-Planck-Institut f\"ur Radioastronomie   |\       /      /o  o\          |
| Abteilung f\"ur Infrarot-Interferometrie    |  \    /      |  /   |         |
| Auf dem H\"ugel 69                          |    \ |        \ ---/          |
| D-53121 Bonn (Germany)          ------------+------+-------------------     |
|                                             |    / |                        |
| Phone (+49) 228 525 319                     |  /  /                         |
| Fax   (+49) 228 525 411                     |/   /                          |
| Mail  ad@mpifr-bonn.mpg.de                                                  |
+-------------- electrical engineers do it with less resistance --------------+
--------------9DC1AE5D05AFD88BD7A6B247
Content-Type: application/octet-stream;
 name="PBG3-300-Hint-NetQUIPS.tar.gz"
Content-Disposition: attachment;
 filename="PBG3-300-Hint-NetQUIPS.tar.gz"
Content-Transfer-Encoding: base64

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
rLEtbupACDsQ4RVJVdMgaxmwcCuyqqZJVoeLtaqsrGmQtR2zKiormtCO9HENraxpQsDPBlUE
sqZZtj4yWdMg69W0ei06Tcd2654VNY3e0je8pbd4y9LdcV3WbfHBqBYFo/YoMOtY9ZY5sAyr
FjGqZitZlU2LhMYfb/EFtPRnnFDsOvGDkCWbTGX5Uq+kpVr6Kw7XzGSG9uL8b+3Ubm/OL46u
d0H/18v/Zzkl/j/wPDEc+Iz8fy9Rnsn/VwmS3dD/mQ7S/yH9H9L/If0f0v8h/R/S/yH9H9L/
If0f0v8h/R/S/yH9H9L/If0f0v8h/d/zvYX0f0j/h/R/SP+H9H9I/4f0f0j/h/R/SP+H9H9I
/4f0f0j/h/R/m7qR/g/p/5D+D+n/kP4P6f+Q/g/p/5D+D+n/kP4P6f+Q/g/p/5D+D+n/uEqk
/3se/d8QiizD9Xo49nKBAdCk6BBoDbQJm0R2+qib9awQ6IemRHdFmmg6ejexWCEwAJqj75I0
UX1PuwNaLjAAmhTdFWmiZZndy6AQ6IemRHdFmmh5VvcyKAQGQJOiuyJNtA27exkUAv3QlOjO
SBO/F8FeA2kiEuwhwR4S7CHBHhLsIcEeEuwhwR4S7CHBHhLsIcEeEuwhwR4S7P3uCPbuwtjP
kF/vRfj1XL3KayaOm5jVrDpnnqppkh2P64xxsuaZspZXJ4zzWvjiTGdcRytrGrnd6lx8qqaR
s268wW83buG3c2panTaslmFteLaN327s1FkOZU2zbF2vrHkxrHVfqZpm2Tpvn6z5f8Sv91sv
7dRucBbYCfvfAP4/11nz/9mC/89wLOT/e4nyTP6/UpDshv3PspH9D9n/kP0P2f+Q/Q/Z/5D9
D9n/kP0P2f+Q/Q/Z/5D9D9n/kP0P2f+Q/Q/Z/57vLWT/Q/Y/ZP9D9j9k/0P2P2T/Q/Y/ZP9D
9j9k/0P2P2T/Q/Y/ZP/b1I3sf8j+h+x/yP6H7H/I/ofsf8j+h+x/yP6H7H/I/ofsf8j+h+x/
yP7HVSL73/PY/4ZQ7H0n9r9BPHbfh/1vCFncd2L/G8TI9p3o/4wGEoHfCv+fMWQlfCcCQGPI
UvheDIBD1sJ3YgA0G9YCMgAiAyAyACIDIDIAIgMgMgAiAyAyACIDIDIAIgMgMgAiAyAyAP7u
GADBO8j/9yL8f+YGrV8rq59n1bnfZE0TT55p11j9VE2jrGnVZc02njq9hlZWNKLdYKrz2pjq
LHODWNBsYxaEljoDoKxpwlAnFjTbeAXBk96Gb70WBPp4ROochKMWWUOvy8qaJgzfEAn1GVM1
zZGw4S+7xV+WaW3Mg1XxGLIAYsGCBQsWLFiwYMGCBQsWLFiwYMGCBQsWLFiwYMGCBQsWLFiw
YMGCBQsWLFiwDC//AoYz6HAAGAEA
--------------9DC1AE5D05AFD88BD7A6B247--


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
